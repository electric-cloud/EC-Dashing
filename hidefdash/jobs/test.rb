st = Time.now.to_i
prog_val1 = 0
prog_val2 = 0
prog_val3 = 0

SCHEDULER.every '2s' do  
  send_event('test-elapsed1', {start_time: st})
  send_event('test-prog1', {progress_items: [{name: 'Universe entropy', progress: prog_val1},
                                             {name: 'My coffee pot', progress: prog_val2},
                                             {name: 'My attention span', progress: prog_val3}]})
  prog_val1 += 0.5
  prog_val2 += 1
  prog_val3 += 2
  
  if prog_val1 > 100
    prog_val1 = 0
  end
  
  if prog_val2 > 100
    prog_val2 = 0
  end
  
  if prog_val3 > 100
    prog_val3 = 0
  end
  
end