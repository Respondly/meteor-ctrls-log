###
Provides a read/write handle to a log item.
This allows a log item to be updated after it has been initially added.
###
LogHandle = stampit().enclose ->
  ctrl = null


  # ----------------------------------------------------------------------


  ###
  Initializes the handle.
  @param itemCtrl: The { c-log-item } Ctrl that is being controlled.
  ###
  @init = (itemCtrl) ->
    throw new Error('Log item Ctrl not specified.') unless itemCtrl?
    ctrl = itemCtrl
    ctrl.onDestroyed => @dispose()


  ###
  Gets or sets the title on the item.
  ###
  @title = (value) ->
    result = ctrl?.title(value)
    return if value is undefined then result else @  # Allow method chaining.


  ###
  Gets or sets the sub-title on the item.
  ###
  @subtitle = (value) ->
    result = ctrl?.subtitle(value)
    return if value is undefined then result else @  # Allow method chaining.


  ###
  Gets or sets the value (pass through to the [write] method).
  ###
  @value = (value, options) ->
    if value isnt undefined
      @write(value, options)
      @ # Allow method chaining.
    else
      ctrl?.value() # READ.


  ###
  Sets the log value.
  @param value    The value.
  @param options: Optional. The options for the value.
  ###
  @write = (value, options) ->
    ctrl?.write(value, options)
    @




  ###
  Disposes of the log entry.
  ###
  @dispose = ->
    ctrl?.dispose()
    @isDisposed = true


  # ----------------------------------------------------------------------
  return @





