PKG.typeName = (value) ->
  return 'string'   if Object.isString(value)
  return 'number'   if Object.isNumber(value)
  return 'boolean'  if Object.isBoolean(value)
  return 'date'     if Object.isDate(value)
  return 'function' if Object.isFunction(value)
  return 'object'   if Util.isObject(value)
  'unknown-type'


# ----------------------------------------------------------------------


###
Formats a value.
@param value: The value to format.
@param options:
              - invokeFuncs:  Flag indicating whether functions should be invoked to convert them to a value.
              - isExcluded:   Flag indcating if the value has been exluded from the set.

@returns { value(string) : css-class }
###
PKG.formatValue = (value, options = {}) ->
  invokeFuncs = options.invokeFuncs ? false
  isExcluded = options.isExcluded ? false
  css = ''
  tooltip = null

  if isString = Object.isString(value)
    css += ' c-string'
    value = "\"#{ value }\""

  if isBoolean = Object.isBoolean(value)
    css += ' c-bool'
    value = value.toString()

  if isArray = Object.isArray(value)
    css += ' c-array'
    tooltip = "[#{ value.toString() }]"
    value = "Array[#{ value.length }]"

  if isNumber = Object.isNumber(value)
    css += ' c-number'

  if isDate = Object.isDate(value)
    css += ' c-date'
    tooltip = value.toString()
    formatted = value.format('{d}-{Mon}-{yyyy},{h}:{mm}{tt}')
    value = "<#{ formatted }>"

  if isNull = value is null
    css += ' c-null'
    value = "null"

  if isUndefined = value is undefined
    css += ' c-undefined'
    value = "undefined"

  if isExcluded and value?
    css += ' c-excluded'
    value = "<#{ PKG.typeName(value) }>"

  if Object.isFunction(value)
    css += ' c-func'
    if invokeFuncs
      value = value()
      if Object.isFunction(value)
        value = funcToString(value)
      else
        value = PKG.formatValue(value) # <== RECURSION.
    else
      value = funcToString(value)

  # Finish up.
  result =
    value: value
    css: css
    tooltip: tooltip



###
Formats the text of labels within the index tree.
###
PKG.toHtml = (text) ->
  text = Util.asValue(text)
  text = Markdown.toHtml(text)
  text = text.replace /\n/g, '<br>'
  text = '&nbsp;' if Util.isBlank(text)
  text




# PRIVATE ----------------------------------------------------------------------



funcToString = (fn) =>
      params = Util.params(fn).join(', ')
      "function (#{ params })"
