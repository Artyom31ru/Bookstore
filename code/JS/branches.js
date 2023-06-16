var branchesApp = new Vue({
	el: '#branchesApp',
	data:{
		branches: '',
		newBranch:{
			city: '',
			street: '',
			home: '',
		},
		updateBranch:{
			id: 0,
			city: '',
			street: '',
			home: '',
		},
	},
	methods:{
		GetBranches: function(){
			axios.get('PHP/get_branches_list.php')
			.then(function(res){
				branchesApp.branches = res.data
			})
		},

		SetNullBranch: function(){
			this.updateBranch.city = ''
			this.updateBranch.street = ''
			this.updateBranch.home = ''
		},

		GetUpdateBranch: function(branch){
			this.updateBranch.id = branch.id_branch
			this.updateBranch.city = branch.city
			this.updateBranch.street = branch.street
			this.updateBranch.home = branch.home
		},
		
		AddBranch: function(){
			axios.post('PHP/add_branch.php', branchesApp.newBranch)
			.then(function(res){
				branchesApp.GetBranches()
				branchesApp.SetNullBranch()
			})
			.catch(function(error){
				ERR(error)
			})
			
		},

		DeleteBranch: function(id){
			if (confirm("Вы уверены, что хотите удалить?"))
			axios.get('PHP/delete_branch.php?id='+id)
			.then(function(res){
				branchesApp.GetBranches()
			})
			.catch(function(error){
				ERR(error)
			})
		},
		
		UpdateBranch: function(id){
			axios.post('PHP/update_branch.php', branchesApp.updateBranch)
			.then(function(res){
				branchesApp.GetBranches()
				branchesApp.updateBranch.id = 0
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

branchesApp.Main()