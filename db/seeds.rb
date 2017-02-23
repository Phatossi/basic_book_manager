author = Author.create({
    id: 1,
    name: 'Ryan Holiday',
    age: 29
    })


Book.create({
    id: 1,
    title: 'Ego is the enemy',
    isbn: 'ISBN 1',
    author: author
    })

Book.create({
    id: 2,
    title: 'The obstacle is the way',
    isbn: 'ISBN 2',
    author: author
    })
