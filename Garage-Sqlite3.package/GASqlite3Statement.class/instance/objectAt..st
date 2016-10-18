public
objectAt: aColumn
	^ FLMaterializer materializeFromByteArray: (GASqlite3FFI current blobFrom: handle at: aColumn)