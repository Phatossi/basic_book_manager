author = Author.create({
    id: 1,
    name: 'Ryan Holiday',
    age: 29
    })


first_book = Book.create({
    id: 1,
    title: 'Ego is the enemy',
    isbn: 'ISBN 1',
    })

second_book = Book.create({
    id: 2,
    title: 'The obstacle is the way',
    isbn: 'ISBN 2',
    })

AuthorsBook.create({
    author: author,
    book: first_book
    })

AuthorsBook.create({
    author: author,
    book: second_book
    })

