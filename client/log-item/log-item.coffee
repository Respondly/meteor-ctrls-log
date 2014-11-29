###
A single row in the log.
###
Ctrl.define
  'c-log-item':
    init: ->
      @api.write(@data.value, @data.options)


    api:
      title: (value) -> @prop 'title', value
      subtitle: (value) -> @prop 'subtitle', value
      value: (value) -> @prop 'value', value


      write: (value, options) ->
        @api.value(value)

        isValueType = ->
            return true if not value?
            return true if Object.isString(value)
            return true if Object.isNumber(value)
            return true if Object.isBoolean(value)
            return true if Object.isDate(value)
            return true if Object.isFunction(value)
            false

        getType = ->
            return if value is undefined and options.showUndefined is false
            return 'c-log-value' if isValueType()
            return 'c-json' if Util.isObject(value)

        if type = getType()
          data = Object.clone(options ? {})
          data.value = value
          def =
            type: type
            data: data

        @helpers.valueCtrl(null) # Force a new value ctrl.
        Deps.afterFlush => @helpers.valueCtrl(def ? null)



    helpers:
      valueCtrl: (value) -> @prop 'valueCtrl', value

      title: -> PKG.toHtml(@api.title())
      subtitle: -> PKG.toHtml(@api.subtitle())

