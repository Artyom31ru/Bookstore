var genresApp = new Vue({
	el: '#genresApp',
	data:{
		genres: '',
		newGenre:{
			genre: '',
		},
		updateGenre:{
			id: 0,
			genre: '',
		},
	},
	methods:{
		GetGenres: function(){
			axios.get('PHP/get_genres_list.php')
			.then(function(res){
				genresApp.genres = res.data
			})
		},
		
		SetNullGenre: function(){
			this.newGenre.genre = ''
		},

		GetUpdateGenre: function(genre){
			this.updateGenre.id = genre.id_genre
			this.updateGenre.genre = genre.genre
		},

		AddGenre: function(){
			axios.post('PHP/add_genre.php', genresApp.newGenre)
			.then(function(res){
				genresApp.GetGenres()
				genresApp.SetNullGenre()
			})
			.catch(function(error){
				ERR(error)
			})
			
		},
		DeleteGenre: function(id){
			if (confirm("Вы уверены, что хотите удалить?"))
			axios.get('PHP/delete_genre.php?id='+id)
			.then(function(res){
				genresApp.GetGenres()
			})
			.catch(function(error){
				ERR(error)
			})
		},
		
		UpdateGenre: function(id){
			axios.post('PHP/update_genre.php', genresApp.updateGenre)
			.then(function(res){
				genresApp.GetGenres()
				genresApp.updateGenre.id = 0
			})
			.catch(function(error){
				ERR(error)
			})
		},

		Main: function(){
			this.GetGenres()
		}
	}
})

genresApp.Main()