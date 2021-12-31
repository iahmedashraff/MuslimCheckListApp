#  Documentation

1- iam using firestore with structure 
user collection
docment userData that include
  id
  name
  screens (collection) that contain = array of screen records
    docments
       screenName
        type 1 = pray , 2 = zikr
        id with type == 1 
          id = 1 (fajr)
          .
          .
          .
          .
        id with type == 2
          id = 1 (morning zikr)
        date

