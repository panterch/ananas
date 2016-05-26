module CapybaraHelper
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time * 2) do
      loop until page.evaluate_script('jQuery.active').zero?
    end
  end
end
