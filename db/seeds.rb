
author = Author.create({
   id: 2,
   name: 'First Author',
   age: 31
})


Book.create({
  id: 1,
  title: 'First book',
  isbn: 'ISBN',
  author: author
})
