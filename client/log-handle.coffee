###
Provides a read/write handle to a log item.
This allows a log item to be updated after it has been initially added.
###
LogHandle = stampit().enclose ->
  ctrl = null
  initState = {}
  isInitialized = false


  # ----------------------------------------------------------------------


  ###
  Initializes the handle.
  @param itemCtrl: The { c-log-item } Ctrl that is being controlled.
  ###
  @init = (itemCtrl) ->
    # Setup initial conditions.
    return if isInitialized
    throw new Error('Log item Ctrl not specified.') unless itemCtrl?

    # Manage Ctrl.
    ctrl = itemCtrl
    ctrl.onDestroyed => @dispose()

    # Set initial state.
    @title(initState.title) if initState.title isnt undefined
    @subtitle(initState.subtitle) if initState.subtitle isnt undefined
    @write(initState.value, initState.options) if initState.value isnt undefined

    # Finish up.
    isInitialized = true


  ###
  Disposes of the log entry.
  ###
  @dispose = ->
    ctrl?.dispose()
    @isDisposed = true


  # ----------------------------------------------------------------------


  ###
  Gets or sets the title on the item.
  ###
  @title = (value) ->
    initState.title = value if value isnt undefined and not ctrl?
    result = ctrl?.title(value)
    return if value is undefined then result else @  # Allow method chaining.


  ###
  Gets or sets the sub-title on the item.
  ###
  @subtitle = (value) ->
    initState.subtitle = value if value isnt undefined and not ctrl?
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
    if value isnt undefined and not ctrl?
      initState.value = value
      initState.options = value

    ctrl?.write(value, options)
    @


  # ----------------------------------------------------------------------
  return @





