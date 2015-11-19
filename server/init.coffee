Meteor.startup ->
  if Objects.findOne({type: "addAction"})
    console.log "addAction is already existing!"
  else
    Objects.insert
      type: "addAction"
      createdBy: "samuelandert.com"
      createdAt: new Date()
      on: "change"
      inline: true
      fields:
        description:
          identifier: 'description'
          rules: [
            {
              type  : 'empty'
              prompt: 'please enter a value'
            }
            {
              type  : 'maxLength[120]',
              prompt: 'Please enter at most 120 characters'
            }
            {
              type  : 'minLength[3]',
              prompt: 'Please enter at least 3 characters'
            }
          ]
    console.log "addAction has been initialized"
