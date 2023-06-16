var sellersApp = new Vue({
	el: '#sellersApp',
	data:{
		sellers: '',
		branches: '',
		newSeller:{
			surname: '',
			firstname: '',
			patronymic: '',
			branch_id: 0,
			salary: 10000,
		},
		updateSeller:{
			id: 0,
			surname: '',
			firstname: '',
			patronymic: '',
			branch_id: '',
			salary: '',
		},
		sort: 'order by id_seller',
	},
	methods:{
		GetBranches: function(){
			axios.get('PHP/get_branches_list.php')
			.then(function(res){
				sellersApp.branches = res.data
			})
		},

		GetSellers: function(){
			axios.get('PHP/get_sellers_list.php?sort=' + encodeURIComponent(sellersApp.sort))
			.then(function(res){
				sellersApp.sellers = res.data
			})
		},

		SetNullSeller: function(){
			this.newSeller.surname = ''
			this.newSeller.firstname = ''
			this.newSeller.patronymic = ''
			this.newSeller.branch_id = 0
			this.newSeller.salary = 10000
		},

		GetUpdateSeller: function(seller){
			this.updateSeller.id = seller.id_seller
			this.updateSeller.surname = seller.surname
			this.updateSeller.firstname = seller.firstname
			this.updateSeller.patronymic = seller.patronymic
			this.updateSeller.branch_id = seller.branch_id
			this.updateSeller.salary = seller.salary
		},
		
		AddSeller: function(){
			axios.post('PHP/add_seller.php', sellersApp.newSeller)
			.then(function(res){
				sellersApp.GetSellers()
				sellersApp.SetNullSeller()
			})
			.catch(function(error){
				ERR(error)
			})			
		},

		DeleteSeller: function(id){
			if (confirm("Вы уверены, что хотите удалить?"))
			axios.get('PHP/delete_seller.php?id='+id)
			.then(function(res){
				sellersApp.GetSellers()
			})
			.catch(function(error){
				ERR(error)
			})
		},
		
		UpdateSeller: function(id){
			axios.post('PHP/update_seller.php', sellersApp.updateSeller)
			.then(function(res){
				sellersApp.GetSellers()
				sellersApp.updateSeller.id = 0
			})
			.catch(function(error){
				ERR(error)
			})
		},

		Main: function(){
			this.GetSellers()
			this.GetBranches()
		}
	}
})

sellersApp.Main()