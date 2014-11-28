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
    ctrl?.title(value)
    return @ if value isnt undefined # Allow method chaining.


  ###
  Gets or sets the sub-title on the item.
  ###
  @subtitle = (value) ->
    ctrl?.subtitle(value)
    return @ if value isnt undefined # Allow method chaining.


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





