# Academic Normalization
If you’re taking a college course about databases, you will likely run into formal terms about normalization. In this article, you will learn what the 1NF, 2NF, and 3NF normal forms and how they relate to update, insertion, and deletion anomalies.

## What is NF?
In most academic situations, the terms 1NF, 2NF, and 3NF will be the formal vocabulary for describing a normalized database. But what do these terms mean? In each term, the NF stands for Normal Form. The numbers stand for what level of normalization the database is.

## A 1NF Database
The first type of database we’ll talk about is a 1NF database, or a 1 Normal Form database. A 1NF database is an atomic database. An atomic database is when each cell contains one value, and each row is unique. We use the term atomic to indicate that the data is no longer divisible, like an atom. An example of a non-1NF database can be seen below.

__Book.db__
| Book Title | Book Author | Author Address | Book Sales |
|------------|-------------|----------------|------------|
|A Wrinkle in Time | Madeleine L’Engle | 123 Street Road | $1.3 million |
| The Lord of the Rings, The Hobbit | J.R.R. Tolkien | 47 The Shire	$9.9 million |

We can look at this database and see that we have two different values in the `Book Title` column for The `Lord of the Rings` and `The Hobbit`. This causes problems for us if we wanted to get information specific for `The Lord of the Rings`, as we would get information for `The Hobbit` as well. To fix this issue, we would separate the two books into their own rows, like this:

__Book1NF.db__
|Book Title | Book Author | Author Address | Book Sales |
|---|---|---|---|
| A Wrinkle In Time |	Madeleine L’Engle | 123 Street Road | $1.3 million| 
| The Lord of the Rings | J.R.R. Tolkien | 47 The Shire | $5.6 million|
|The Hobbit | J.R.R. Tolkien | 47 The Shire | $4.3 million | 

Now when we want to get information for The Lord of the Rings we can get information specific for that book. However, there are still some issues that can happen with this database that we will discuss soon.


Multiple choice
What rule needs to be followed for a database to be considered 1NF?

* The database contains data.
* (Selected)Correct:The database is atomic.
* The database has at least one table.
* The database is able to be queried.

👏 Correct! In order for a database to be considered 1NF it must be atomic.

## A 2NF Database
The next step when normalizing a database would be to make the database 2NF. When a database is 2NF, it means that the database is 1NF and does not contain any partial dependencies. But what is a partial dependency? A partial dependency is when an attribute depends on part of the table’s primary key rather than the whole primary key. For an example, let’s take a look at the table below:

__Book.db__

| Book ID (PK) | Book Title | Book Sales | Author ID | Book Author | Author Address |
|---|---|---|---|---|---|
|1 | A Wrinkle in Time | $1.3 million | 1 | Madeleine L’Engle | 123 Street Road |
2 | The Lord of the Rings | $5.6 million | 2 | J.R.R. Tolkien | 47 | The Shire |
|3 | The Hobbit | $4.3 million | 2 | J.R.R. Tolkien | 47 | The Shire| 

With this table we can see that there is an ID for the book and an ID for the author. We can determine the `Book Title` based on the `Book ID` and the `Author` based on the `Author ID`. These are both partial dependencies since the `Author ID` depends partially on the `Book ID`. To remove these dependencies we need to split this table into two different tables. One for the `Book` fields and one for the `Author` fields. The resulting tables would look like this:

__Book.db__

| Book ID (PK) | Author ID (FK) | Book Title | Book Sales|
|---|---|---|---|
1|	1|	A Wrinkle In Time.|	$1.3 million|
2|	2|	The Lord of the Rings|	$5.6 million|
3|	2|	The Hobbit|	$4.3 million|

__Author.db__

|Author ID (PK)|	Author Name|	Author Address|
|---|---|---|
|1|	Madeleine L’Engle|	123 Street Road|
|2|	J.R.R. Tolkien|	47 The Shire|

Now when we look at the database we see that the author depends on the `Author ID` in its own table rather than author depending on `Author ID` which then depends partially on the `Book ID`. This means that if we want to find the author we can just use their ID rather than finding the book ID and then the `author ID`.

This also helps prevent a few anomalies when updating and deleting data from the database. For instance, if we wanted to update the address of J.R.R. Tolkien, instead of finding every one of his books in the `Book.db` table and updating his address, we can update his address from the `Author.db` table once. This decreases the chances that we miss updating one of the Author Address records which would lead to J.R.R. Tolkien having two separate addresses in the database rather than one. This would be called an update anomaly.

This also keeps us from deleting an author from the database unless we want to, otherwise known as causing a deletion anomaly. This is because in the original database, if we deleted every book made by an author we would end up getting rid of the author completely when we just wanted to get rid of their books from the database. Now we can delete every book by an author in the `Book.db` table, without deleting the author from the` Author.db` table.

Multiple choice
What is a 2NF database?

* A database that contains partial dependencies.
* A database with no partial dependencies.
* A 1NF database with more tables.
* (Selected)Correct: A database that is 1NF and contains no partial dependencies.

👏
Correct! A 2NF database needs to be both 1NF and contain no partial dependencies.

Multiple choice
What type of anomaly would lead to different records existing for the same object?

* A read anomaly.
* (Selected)Correct: An update anomaly.
* A deletion anomaly.
* An insertion anomaly.

👏
Correct!

## A 3NF Database
The last level of normalization we’ll cover in this article is to make the database 3NF. A database is described as 3NF when it is 2NF but also has no transitive functional dependencies. A transitive functional dependency is when a non-prime attribute depends on another non-prime attribute rather than a primary key or prime attribute.

Let’s go back to our book database to see an example of this. let’s say we wanted to find the author’s address. We would first go from the book table to the author table, and from the author table, we can find their address. This might not seem like a big deal, but the address is dependent on the author, meaning if we were to delete the author we would come across another deletion anomaly. To fix this, we would create a table for the addresses. This would make our database look like the one below:

__Book.db__

|Book ID (PK)|	Author ID (FK)|	Book Title|	Book Sales|
|---|---|---|---|
|1|	1|	A Wrinkle In Time|	$1.3 million|
|2|	2|	The Lord of the Rings|	$5.6 million|
|3|	2|	The Hobbit|	$4.3 million|

__Author.db__

|Author ID (PK)| Address ID (FK)| Author Name|
|---|---|---|
|1|	1|	Madeleine L’Engle|
|2|	2|	J.R.R. Tolkien|

__Address.db__

|Address ID (PK)| Address|
|---|---|
|1|	123 Street Road|
|2|	47 The Shire|


Now when we want to find the author’s address, we start with a book, find the author, find the address key in the author table, and get the address from the address table. While this may seem to increase the number of searches done in a query by connecting more tables, it saves us some trouble down the line by not having to add multiple addresses if multiple authors are in one building, or by having to add an address again if the author is deleted from the database.

Another modification we can make to our database is to make the `Book Sales` a table of its own. This would be useful if we add books before they are published as it would prevent insertion anomalies from happening. An insertion anomaly occurs when a row is added to a database without all the data it needs. For instance, if we wanted to add a book to the database before it sold a copy, `Book Sales` would be `NULL` causing an incomplete row which could prevent us from adding the book to the database. But for now we’ll just assume that with our database the books are added after they make their first sales.