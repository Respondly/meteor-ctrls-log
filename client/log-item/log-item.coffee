Ctrl.define
  'c-log-item':
    init: ->
      @api.write(@data.value, @data.options)


    api:
      title: (value) -> @prop 'title', value


      write: (value, options) ->
        isValueType = ->
            return true if not value?
            return true if Object.isString(value)
            return true if Object.isNumber(value)
            return true if Object.isBoolean(value)
            return true if Object.isDate(value)
            return true if Object.isFunction(value)
            false

        getType = ->
            return 'c-log-value' if isValueType()
            return 'c-json' if Object.isObject(value)

        if type = getType()
          data = Object.clone(options ? {})
          data.value = value
          def =
            type: type
            data: data

        @helpers.itemCtrl(null)
        Deps.afterFlush => @helpers.itemCtrl(def ? null)



    helpers:
      itemCtrl: (value) -> @prop 'itemCtrl', value

