Ctrl.define
  'c-log':
    api:
      ###
      REACTIVE: The total number of items within the log.
      ###
      count: (value) -> @prop 'count', value, default:0


      ###
      Clears the log.
      ###
      clear: ->
        child.dispose() for child in Object.clone(@children)
        @api.count(0)


      value: (value, options) ->
        @api.write(value, options) if value isnt undefined
        value


      ###
      The general purpose log method that infers the way to
      log the given value based on it's type.
      @param value.
      @param options
      @returns a [Log] handle.
      ###
      write: (value, options  = {}) ->
        @api.count(@api.count() + 1)
        args =
          data:
            value: value
            options: options
        ctrl = @appendCtrl('c-log-item', @el(), args)
        ctrl.onReady => @api.scrollToBottom()
        ctrl



      ###
      Scrolls the log to the bottom.
      @param options
                - duration:   The animation duration (in seconds).

      ###
      scrollToBottom: (options = {}, callback) ->
        if Object.isFunction(options)
          callback = options
          options = {}
        duration = options.duration ? 0.2
        el = @el()
        elParent = @helpers.scrollParent()
        scrollTo = el.outerHeight() - elParent.height()
        scrollTo = 0 if scrollTo < 0
        elParent.animate { scrollTop:scrollTo }, duration.seconds(), -> callback?()




    helpers:
      scrollParent: ->
        if not @_scrollParent
          el = @el().scrollParentY()
          el ?= $('body')
          @_scrollParent = el
        @_scrollParent



