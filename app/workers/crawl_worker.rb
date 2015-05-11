class CrawlWorker
  include Sidekiq::Worker

  def perform(page)
    response = HTTParty.get("https://www.acmicpc.net/problemset/#{page}")
    parsed_html = Nokogiri::HTML(response.body)
    problems = parsed_html.xpath("//tr").to_a

    # 첫번째 라인은 범례이기 때문에 필요가 없습니다.
    problems.delete_at 0 if problems.length > 0

    # 데이터베이스에 파싱 결과를 집어넣습니다.
    problems.each do |parsed_problem|
      parsed_problem = parsed_problem.xpath("td")
      problem = Problem.find_or_initialize_by code: parsed_problem[0].content.to_i

      problem.title = parsed_problem[1].content
      problem.success = parsed_problem[3].content.to_i
      problem.trial = parsed_problem[4].content.to_i
      problem.percentage = (parsed_problem[5].content.to_f * 1000).to_i

      problem.save!
      logger.info "Inserted Problem ##{problem.code}"
    end

    # 다음 Worker를 호출합니다. 아무것도 없는 경우 하지 않습니다.
    if problems.length > 0
      CrawlWorker.perform_async page+1
    end
  end
end
