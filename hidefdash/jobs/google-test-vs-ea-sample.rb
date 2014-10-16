# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
g_test = 1
ea_test = 1
g_progress = 0
e_progress = 0

st = Time.now.to_i
send_event('test_elapsed', {start_time: st})

SCHEDULER.every '2s', :first_in => 0 do |job|
=begin
  send_event('google_test_count', { current: g_test += rand(10) })
  send_event('ea_test_count', { current: ea_test += rand(50) })
  send_event('google_test_rate', { value: rand(20) })
  send_event('ea_test_rate', { value: rand(50) })

  send_event('google_test_progress', {progress_items: [
    {name: "Current Google test", progress: g_progress}
    ]})
  send_event('ea_test_progress', {progress_items: [
        {name: "Current EA test", progress: e_progress}
                                              ]})
  g_progress += 1
  e_progress += 2

  send_event('google_last_tests', {
              points: [
                {"x" => 0, "y" => 100},
                {"x" => 1, "y" => 200 },
                {"x" => 2, "y" => 300 },
                {"x" => 3, "y" => 10 },
                {"x" => 4, "y" => 50 },
                {"x" => 5, "y" => 120 },
                {"x" => 6, "y" => 590 },
                {"x" => 7, "y" => 330 },
                {"x" => 8, "y" => 220 },
                {"x" => 9, "y" => 50 }
               ]})
  send_event('ea_last_tests', {
              points: [
                {"x" => 0, "y" => 10},
                {"x" => 1, "y" => 20 },
                {"x" => 2, "y" => 30 },
                {"x" => 3, "y" => 1 },
                {"x" => 4, "y" => 5 },
                {"x" => 5, "y" => 12 },
                {"x" => 6, "y" => 59 },
                {"x" => 7, "y" => 33 },
                {"x" => 8, "y" => 22 },
                {"x" => 9, "y" => 5 }
               ]})
=end
end
  
  
