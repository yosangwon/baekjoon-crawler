class FolderCrawlWorker
  include Sidekiq::Worker

  def perform(category=nil, parent_folder=nil)
    response = HTTParty.get("https://www.acmicpc.net/category/#{category.to_s}")
    parsed_html = Nokogiri::HTML(response.body)
    folder = Folder.find_or_create_by(original_id: category) do |new_folder|
      new_folder.name = parsed_html.css('h1')[0].content
      new_folder.parent_folder_id = parent_folder
      romanized_slug = Gimchi.romanize(new_folder.name, number: false).parameterize
      new_folder.slug = if new_folder.parent_folder
                          "#{new_folder.parent_folder.slug}#{romanized_slug}/"
                        else
                          "#{romanized_slug}/"
                        end
    end

    folder.parent_folder_id = parent_folder
    folder.save!

    categories = parsed_html.css("#categorylist tr").to_a
    categories.delete_at 0 if categories.length > 0
   
    categories.each do |subfolder|
      subfolder_path = subfolder.css('td a')[0].attribute('href').value.split('/')
      subfolder_original_id = subfolder_path[-1]
      FolderCrawlWorker.perform_async(
        subfolder_original_id, 
        folder.id
      )
    end

    competitions = parsed_html.css("#contestlist tr").to_a
    competitions.delete_at 0 if competitions.length > 0
 
    competitions.each do |subfolder|
      subfolder_path = subfolder.css('td a')[0].attribute('href').value.split('/')
      subfolder_original_id = "detail/#{subfolder_path[-1]}"
      FolderCrawlWorker.perform_async(
        subfolder_original_id, 
        folder.id
      )
    end

    problems = parsed_html.css("#problemset tr").to_a
    problems.delete_at 0 if problems.length > 0
    problems.each_with_index do |foldered_problem, index|
      parsed_problem = foldered_problem.css("td")
      next if parsed_problem[3].content.match("삭제")

      problem = Problem.find_by(code: parsed_problem[0].content.to_i)
      next unless problem

      ProblemFolderRelation.find_or_create_by(problem_id: problem.id, folder_id: folder.id) do |problem_folder_relationship|
        problem_folder_relationship.number = index
        logger.info "문제 #{problem.id}를 폴더 #{folder.slug}에 저장 완료."
        folder.update(type: :competition) if folder.type == :folder
      end
    end
  end
end
