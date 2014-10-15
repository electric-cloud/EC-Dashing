class Dashing.Elapsed extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  @accessor 'init-date-time', ->
    today = new Date()
    date = new Date(parseInt(@get('start_time')) * 1000)
    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s)
    h + ":" + m + ":" + s    

  startTime: =>
    now = new Date()
    started = new Date(parseInt(@get('start_time')) * 1000)
    
    elapsed = now - started
    elapsed /= 1000
    
    s = Math.round(elapsed % 60)
    
    elapsed = Math.floor(elapsed / 60)
    
    m = Math.round(elapsed % 60)
    
    elapsed = Math.floor(elapsed / 60)
    
    h = Math.round(elapsed % 60)

    m = @formatTime(m)
    s = @formatTime(s)
    @set('elapsed-time', h + ":" + m + ":" + s)

  formatTime: (i) ->
    if i < 10 then "0" + i else i