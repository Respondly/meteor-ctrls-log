

###
Provides a handle to a log item.
###
LogHandle = stampit().enclose ->
  ctrl = null
  initialState = null


  # ----------------------------------------------------------------------


  ###
  Initializes the handle.
  @param itemCtrl: The item Ctrl that is being controlled.
  ###
  @init = (itemCtrl) ->
    throw new Error('Log item Ctrl not specified.') unless itemCtrl?
    ctrl = itemCtrl
    ctrl.onDestroyed => @dispose()

    # Finish up.
    if state = initialState
      @value(state.value, state.options)
      initialState = null



  ###
  Gets or sets the log value.
  @param value    The value.
  @param options: Optional. The options for the value.
  ###
  @value = (value, options) ->
    return undefined if @isDisposed
    if ctrl?
      ctrl.value(value)
    else
      # The handle has not been initialized with a Ctrl yet.
      # Store the initial state to load.
      initialState =
        value: value
        options: options
      value




  ###
  Disposes of the log entry.
  ###
  @dispose = ->
    ctrl?.dispose()
    @isDisposed = true


  # ----------------------------------------------------------------------
  return @





