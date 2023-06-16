var booksApp = new Vue({
	el: '#booksApp',
	data:{
		books: '',
		genres: '',
		newBook:{
			title: '',
			author: '',
			genre_id: 0,
			price: 1,
		},
		updateBook:{
			id: 0,
			title: '',
			author: '',
			genre_id: '',
			price: '',
		},
		sort:{
			sort1: ' order by id_book',
			sort2: '',
			sort3: '',
		},
	},
	methods:{
		GetGenres: function(){
			axios.get('PHP/get_genres_list.php')
			.then(function(res){
				booksApp.genres = res.data
			})
		},

		GetBooks: function(){
			axios.post('PHP/get_books_list.php', booksApp.sort)
			.then(function(res){
				booksApp.books = res.data
			})
		},
		
		SetNullBook: function(){
			this.newBook.title = ''
			this.newBook.author = ''
			this.newBook.genre_id = 0
			this.newBook.price = 1
		},

		GetUpdateBook: function(book){
			this.updateBook.id = book.id_book
			this.updateBook.title = book.title
			this.updateBook.author = book.author
			this.updateBook.genre_id = book.genre_id
			this.updateBook.price = book.price
		},

		AddBook: function(){
			axios.post('PHP/add_book.php', booksApp.newBook)
			.then(function(res){
				booksApp.GetBooks()
				booksApp.SetNullBook()
			})
			.catch(function(error){
				ERR(error)
			})
			
		},
		
		DeleteBook: function(id){
			if (confirm("Вы уверены, что хотите удалить?"))
			axios.get('PHP/delete_book.php?id='+id)
			.then(function(res){
				booksApp.GetBooks()
			})
			.catch(function(error){
				ERR(error)
			})
		},
		
		UpdateBook: function(id){
			axios.post('PHP/update_book.php', booksApp.updateBook)
			.then(function(res){
				booksApp.GetBooks()
				booksApp.updateBook.id = 0
			})
			.catch(function(error){
				ERR(error)
			})
		},

		Main: function(){
			this.GetBooks()
			this.GetGenres()
		}
	}
})

booksApp.Main()