Ctrl.define
  'c-json':
    api:
      ###
      Gets or sets the displayed object.
      ###
      value: (value) -> @prop 'value', value

      ###
      Gets or sets whether function values are rendered.
      ###
      showFuncs: (value) -> @prop 'showFuncs', value, default:true


      ###
      Gets or sets whether functions should be invoked to convert them to a value.
      ###
      invokeFuncs: (value) -> @prop 'invokeFuncs', value, default:false


      ###
      Gets or sets the names of properties to exclude from export.
      ###
      exclude: (value) ->
        result = @prop 'exclude', value, default:[]
        result = [result] unless Object.isArray(result)
        result.compact(true)


      ###
      Clears the value and resets to default state.
      ###
      reset: ->
        @api.value(null)
        @api.showFuncs(true)
        @api.invokeFuncs(false)
        @api.exclude(null)



    helpers:
      cssClass: ->
        isRoot = @defaultValue('isRoot', true)
        'c-root' if isRoot

      fullPath: ->
        result = ''
        walk = (level) ->
            return unless level
            if parentKey = level.options.parentKey
              result = "#{ parentKey }.#{ result }"
            walk(level.parent) # <== RECURSION.
        walk(@)
        result.remove /\.$/

      props: ->
        showFuncs = @api.showFuncs()
        invokeFuncs = @api.invokeFuncs()
        exclude = @api.exclude()

        if obj = @api.value()
          result      = []
          circular    = getCircular(obj)
          fullPath    = @helpers.fullPath()

          funcToString = (fn) =>
                params = Util.params(fn).join(', ')
                "function (#{ params })"

          process = (key, value) =>
                if isFunction = Object.isFunction(value)
                  return unless showFuncs
                  if invokeFuncs
                    value = value()


                isExcluded = exclude.any (item) -> item is key
                { value, css } = PKG.formatValue(value, isExcluded:isExcluded)

                if isObject = Util.isObject(value)
                  isCircular = circular.any (item) -> item.path is fullPath
                  if isCircular
                    css += ' c-circular'
                    value = '<circular>'
                    isObject = false
                  else
                    if Object.isEmpty(value)
                      isObject = false # Prevent the string representation being rendered with a child instance.
                      value = '{}'

                result.push
                  key:            key
                  value:          value
                  valueCss:       css
                  isObject:       isObject
                  showFuncs:      showFuncs
                  invokeFuncs:    invokeFuncs
                  exclude:        exclude

          process(key, value) for key, value of obj
          result


# PRIVATE ----------------------------------------------------------------------


getCircular = (parent, path, objects = [], circular = []) ->
  return [] unless Object.isObject(parent)
  for key, value of parent

    isCircular = objects.any (item) -> item.value is value
    if isCircular
      circular.push({ value:parent, path:path })

    if Util.isObject(value)
      objects.push({ key:key, value:value, path:path })
      unless isCircular
        childPath = if path then "#{ path }.#{ key }" else key
        getCircular(value, childPath, objects, circular) # <== RECURSION.

  circular


