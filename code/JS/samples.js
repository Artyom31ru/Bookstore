var samplesApp = new Vue({
	el: '#samplesApp',
	data:{
		samples: '',
		branches: '',
		nullBooks: '',
		branchID: '',
		newSample:{
			book_id: 0,
			total: 1,
			branch_id: '',
		},
		updateSample:{
			id: 0,
			book_id: '',
			total: '',
			branch_id: '',
		},
	},
	methods:{
		GetBranches: function(){
			axios.get('PHP/get_branches_list.php')
			.then(function(res){
				samplesApp.branches = res.data
			})
		},

		GetBooks: function(){
			axios.get('PHP/get_books_not_branch_list.php?id=' + samplesApp.branchID)
			.then(function(res){
				samplesApp.nullBooks = res.data
			})

		},

		GetSamples: function(){
			axios.get('PHP/get_samples_list.php?id=' + samplesApp.branchID)
			.then(function(res){
				samplesApp.samples = res.data
				samplesApp.GetBooks()
			})
		},

		SetNullSample: function(){
			this.newSample.book_id = 0
			this.newSample.total = 1
		},

		GetUpdateSample: function(sample){
			this.updateSample.id = sample.id_sample
			this.updateSample.book_id = sample.book_id
			this.updateSample.branch_id = sample.branch_id
			this.updateSample.total = sample.total
		},
		
		AddSample: function(){
			this.newSample.branch_id = this.branchID
			axios.post('PHP/add_sample.php', samplesApp.newSample)
			.then(function(res){
				samplesApp.GetSamples()
				samplesApp.SetNullSample()
			})
			.catch(function(error){
				ERR(error)
			})
			
		},

		DeleteSample: function(id){
			if (confirm("Вы уверены, что хотите удалить?"))
			axios.get('PHP/delete_sample.php?id=' + id)
			.then(function(res){
				samplesApp.GetSamples()
			})
			.catch(function(error){
				ERR(error)
			})
		},
		
		UpdateSample: function(id){
			axios.post('PHP/update_sample.php', samplesApp.updateSample)
			.then(function(res){
				samplesApp.GetSamples()
				samplesApp.updateSample.id = 0
			})
			.catch(function(error){
				ERR(error)
			})
		},

		Main: function(){
			this.GetBranches()
		}
	}
})

samplesApp.Main()