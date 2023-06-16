var subordersApp = new Vue({
	el: '#subordersApp',
	data:{
		suborders: '',
		books: '',
		newSuborder:{
			order_id: '',
			book_id: 0,
			quantity: 1,
		},
		updateSuborder:{
			id: 0,
			order_id: '',
			book_id: '',
			quantity: '',
		},
		orderInfo: '',
		OrderID: '',
	},
	methods:{
		GetID: function(){
			var url = new URL(window.location.href)
			this.OrderID = url.searchParams.get("id")
		},

		GetBooks: function(){
			axios.get('PHP/get_books_in_branch_list.php?id=' + subordersApp.OrderID)
			.then(function(res){
				subordersApp.books = res.data
			})

		},

		GetOrderInfo: function(){
			axios.get('PHP/get_order_info.php?id=' + subordersApp.OrderID)
			.then(function(res){
				subordersApp.orderInfo = res.data[0]
			})
		},

		GetSuborders: function(){
			axios.get('PHP/get_suborders_list.php?id=' + subordersApp.OrderID)
			.then(function(res){
				subordersApp.suborders = res.data
				subordersApp.GetBooks()
			})
		},

		SetNullSuborder: function(){
			this.newSuborder.book_id = 0
			this.newSuborder.quantity = 1
		},

		GetUpdateSuborder: function(suborder){
			this.updateSuborder.id = suborder.id_suborder
			this.updateSuborder.order_id = suborder.order_id
			this.updateSuborder.book_id = suborder.book_id
			this.updateSuborder.quantity = suborder.quantity
		},
		
		AddSuborder: function(){
			this.newSuborder.order_id = subordersApp.OrderID
			axios.post('PHP/add_suborder.php', subordersApp.newSuborder)
			.then(function(res){
				subordersApp.GetSuborders()
				subordersApp.SetNullSuborder()
			})
			.catch(function(error){
				ERR(error)
			})
			
		},

		DeleteSuborder: function(id){
			if (confirm("Вы уверены, что хотите удалить?"))
			axios.get('PHP/delete_suborder.php?id='+id)
			.then(function(res){
				subordersApp.GetSuborders()
			})
			.catch(function(error){
				ERR(error)
			})
		},
		
		UpdateSuborder: function(id){
			axios.post('PHP/update_suborder.php', subordersApp.updateSuborder)
			.then(function(res){
				subordersApp.GetSuborders()
				subordersApp.updateSuborder.id = 0
			})
			.catch(function(error){
				ERR(error)
			})
		},

		Main: function(){
			this.GetID()
			this.GetSuborders()
			this.GetOrderInfo()
		}
	}
})

subordersApp.Main()