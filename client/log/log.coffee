Ctrl.define
  'c-log':
    api:
      ###
      Clears the log.
      ###
      clear: ->
        for child in Object.clone(@children)
          child.dispose()



      ###
      The general purpose log method that infers the way to
      log the given value based on it's type.
      @param value
      ###
      log: (value, options  = {}) ->

        if Util.isObject(value) and not Object.isDate(value)
          @api.logJson(value, options)
          return

        # TODO
        value = '<null>' if value is null
        value = '<undefined>' if value is undefined
        value = value?.toString()

        console.log 'TODO | LOG TYPE', value



      ###
      Logs an object tree.
      @param value: The object to load.
      @param options:
                - showFuncs:    Flag indicating whether function values are rendered.
                - invokeFuncs:  Flag indicating whether functions should be invoked to convert them to a value.
                - exclude:      The key name(s) to exclude from the output.
                                String or Array of strings.
      ###

      logJson: (value, options = {}) ->
        args =
          value: value
          options: options
        ctrl = @appendCtrl 'c-json', @el(), args


