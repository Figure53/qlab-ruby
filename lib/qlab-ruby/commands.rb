module QLab
  # All commands QLab accepts
  module Commands
    MACHINE = %w(
      alwaysReply
      connect
      version
      workingDirectory
      workspaces
    )

    WORKSPACE = %w(
      cueLists
      go
      hardStop
      new
      panic
      pause
      reset
      resume
      runningCues
      runningOrPausedCues
      select
      selectedCues
      stop
      thump
      toggleFullScreen
      updates
    )

    CUE = %w(
      actionElapsed
      allowsEditingDuration
      armed
      children
      colorName
      continueMode
      cueTargetId
      cueTargetNumber
      defaultName
      displayName
      duration
      fileTarget
      flagged
      hardStop
      hasCueTargets
      hasFileTargets
      isBroken
      isLoaded
      isPaused
      isRunning
      listName
      load
      loadAt
      name
      notes
      number
      panic
      pause
      percentActionElapsed
      percentPostWaitElapsed
      percentPreWaitElapsed
      postWait
      postWaitElapsed
      preWait
      preWaitElapsed
      preview
      reset
      resume
      sliderLevel
      sliderLevels
      start
      stop
      togglePause
      type
      uniqueID
      valuesForKeys
    )

    GROUP_CUE = %w(
      playbackPositionId
    )

    AUDIO_CUE = %w(
      doFade
      doPitchShift
      endTime
      infiniteLoop
      level
      patch
      playCount
      rate
      sliderLevel
      sliderLevels
      startTime
    )

    FADE_CUE = %w(
      level
      sliderLevel
      sliderLevels
    )

    MIC_CUE = %w(
      level
      sliderLevel
      sliderLevels
    )

    VIDEO_CUE = %w(
      cueSize
      doEffect
      doFade
      doPitchShift
      effect
      effectSet
      endTime
      fullScreen
      infiniteLoop
      layer
      level
      opacity
      patch
      playCount
      preserveAspectRatio
      quaternion
      rate
      scaleX
      scaleY
      sliderLevel
      sliderLevels
      startTime
      surfaceID
      surfaceList
      surfaceSize
      translationX
      translationY
    )

    # in blocks of: all, group, audio, video, osc, midi, devamp, script
    SET_CUES = %w(
      number
      name
      notes
      fileTarget
      cueTargetNumber
      cueTargetId
      preWait
      duration
      postWait
      continueMode
      flagged
      autoLoad
      armed
      colorName

      playbackPositionId

      patch
      startTime
      endTime
      playCount
      infiniteLoop
      rate
      doPitchShift
      doFade

      surfaceID
      patch
      fullScreen
      layer
      opacity
      preserveAspectRatio
      translationX
      translationY
      scaleX
      scaleY
      doEffect
      effectSet

      messageType
      qlabCommand
      qlabCueNumber
      qlabCueParameters
      rawString

      duration
      messageType
      status
      channel
      byte1
      byte2
      byteCombo
      doFade
      endValue
      deviceID
      commandFormat
      command
      qNumber
      qList
      qPath
      macro
      controlNumber
      controlValue
      timecodeString
      hours
      minutes
      seconds
      frames
      subframes
      timecodeFormat
      rawString

      startNextCueWhenSliceEnds
      stopTargetWhenSliceEnds

      scriptSource
    )

    ALL_CUES = (CUE + GROUP_CUE + AUDIO_CUE + FADE_CUE + MIC_CUE + VIDEO_CUE).uniq.sort
  end
end

