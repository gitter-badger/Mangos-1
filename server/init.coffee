Meteor.startup ->
  if Elements.find().count() is 0
    Elements.insert
      createdBy: "Element"
      createdAt: new Date()
      x1: "Element"
      x2: "is a"
      x3: "singelton"

  UploadServer.init
    tmpDir: process.env.PWD + '/.uploads/tmp'
    uploadDir: process.env.PWD + '/.uploads/'
    checkCreateDirectories: true
    getDirectory: (fileInfo, formData) ->
      # create a sub-directory in the uploadDir based on the content type (e.g. 'images')
      formData.contentType
    finished: (fileInfo, formFields) ->
      # perform a disk operation
      return
    cacheTime: 100
    mimeTypes:
      'xml': 'application/xml'
      'vcf': 'text/x-vcard'


