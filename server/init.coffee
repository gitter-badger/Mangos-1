Meteor.startup ->
  if Objects.find().count() is 0
    typeId =
      Objects.insert
        value: "@type"
        type: "@type"

    valueId =
      Objects.insert
        context:
          type: typeId
        value: "@value"
        type: typeId

    languageId =
      Objects.insert
        context:
          type: typeId
          value: valueId
        value: "@language"
        type: typeId

    contextId =
      Objects.insert
        context:
          type: typeId
          value: valueId
        value: "@context"
        type: typeId

    valdiateId =
      Objects.insert
        context:
          type: typeId
          value: valueId
        value: "validate"
        type: typeId

    stringId =
      Objects.insert
        context:
          type: typeId
          value: valueId
        value: "string"
        type: typeId

    Objects.update valueId,
      $set:
        context:
          value: valueId

    Objects.update typeId,
      $set:
        context:
          value: valueId
          type: typeId
