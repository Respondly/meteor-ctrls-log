PKG.typeName = (value) ->
  return 'string'  if Object.isString(value)
  return 'number'  if Object.isNumber(value)
  return 'boolean' if Object.isBoolean(value)
  return 'date'    if Object.isDate(value)
  return 'object'  if Util.isObject(value)
  'unknown-type'


# ----------------------------------------------------------------------


###
Formats a value.
@param value: The value to format.
@param options:
            isExcluded: Flag indcating if the value has been exluded from the set.
                        Default:false

@returns { value(string) : css-class }
###
PKG.formatValue = (value, options = {}) ->
  isExcluded = options.isExcluded ? false
  css = ''

  if isString = Object.isString(value)
    css += ' c-string'
    value = "\"#{ value }\""

  if isBoolean = Object.isBoolean(value)
    css += ' c-bool'
    value = value.toString()

  if isArray = Object.isArray(value)
    css += ' c-array'
    value = "Array[#{ value.length }]"

  if isNumber = Object.isNumber(value)
    css += ' c-number'

  if isDate = Object.isDate(value)
    css += ' c-date'
    value = "<#{ value.toString() }>"

  if isNull = value is null
    css += ' c-null'
    value = "null"

  if isUndefined = value is undefined
    css += ' c-undefined'
    value = "undefined"

  if isExcluded and value?
    css += ' c-excluded'
    value = "<#{ PKG.typeName(value) }>"


  # Finish up.
  result =
    value: value
    css: css
