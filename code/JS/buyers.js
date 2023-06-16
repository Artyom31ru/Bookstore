var buyersApp = new Vue({
	el: '#buyersApp',
	data:{
		buyers: '',
		newBuyer:{
			surname: '',
			firstname: '',
			phone: '',
		},
		updateBuyer:{
			id: 0,
			surname: '',
			firstname: '',
			phone: '',
		},
	},
	methods:{
		GetBuyers: function(){
			axios.get('PHP/get_buyers_list.php')
			.then(function(res){
				buyersApp.buyers = res.data
			})
		},

		SetNullBuyer: function(){
			this.newBuyer.surname = ''
			this.newBuyer.firstname = ''
			this.newBuyer.phone = ''
		},

		GetUpdateBuyer: function(buyer){
			this.updateBuyer.id = buyer.id_buyer
			this.updateBuyer.surname = buyer.surname
			this.updateBuyer.firstname = buyer.firstname
			this.updateBuyer.phone = buyer.phone
		},
		
		AddBuyer: function(){
			axios.post('PHP/add_buyer.php', buyersApp.newBuyer)
			.then(function(res){
				buyersApp.GetBuyers()
				buyersApp.SetNullBuyer()
			})
			.catch(function(error){
				ERR(error)
			})
			
		},

		DeleteBuyer: function(id){
			if (confirm("Вы уверены, что хотите удалить?"))
			axios.get('PHP/delete_buyer.php?id='+id)
			.then(function(res){
				buyersApp.GetBuyers()
			})
			.catch(function(error){
				ERR(error)
			})
		},
		
		UpdateBuyer: function(id){
			axios.post('PHP/update_buyer.php', buyersApp.updateBuyer)
			.then(function(res){
				buyersApp.GetBuyers()
				buyersApp.updateBuyer.id = 0
			})
			.catch(function(error){
				ERR(error)
			})
		},

		Main: function(){
			this.GetBuyers()
		}
	}
})

buyersApp.Main()