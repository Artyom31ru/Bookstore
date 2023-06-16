var ordersApp = new Vue({
	el: '#ordersApp',
	data:{
		orders: '',
		buyers: '',
		sellers: '',
		newOrder:{
			buyer_id: 0,
			seller_id: 0,
		},
		updateOrder:{
			id: 0,
			buyer_id: '',
			seller_id: '',
		},
		date: new Date().toISOString(),
		subordersShow: 0,
	},
	methods:{
		GoToSuborders: function(id){
			location.href='suborders.php?id=' + id
		},

		GetBuyers: function(){
			axios.get('PHP/get_buyers_list.php')
			.then(function(res){
				ordersApp.buyers = res.data
			})
		},

		GetSellers: function(){
			axios.get('PHP/get_sellers_list.php')
			.then(function(res){
				ordersApp.sellers = res.data
			})
		},

		GetOrders: function(){
			axios.get('PHP/get_orders_list.php')
			.then(function(res){
				ordersApp.orders = res.data
				ordersApp.GetBuyers()
				ordersApp.GetSellers()
			})
		},	

		SetNullOrder: function(){
			this.newOrder.buyer_id = 0
			this.newOrder.seller_id = 0
		},

		GetUpdateOrder: function(order){
			this.updateOrder.id = order.id_order
			this.updateOrder.buyer_id = order.buyer_id
			this.updateOrder.seller_id = order.seller_id
		},	
		
		AddOrder: function(){
			axios.post('PHP/add_order.php', ordersApp.newOrder)
			.then(function(res){
				ordersApp.GetOrders()
				ordersApp.SetNullOrder()
			})
			.catch(function(error){
				ERR(error)
			})
			
		},

		DeleteOrder: function(id){
			if (confirm("Вы уверены, что хотите удалить?"))
			axios.get('PHP/delete_order.php?id='+id)
			.then(function(res){
				ordersApp.GetOrders()
			})
			.catch(function(error){
				ERR(error)
			})
		},
		
		UpdateOrder: function(id){
			axios.post('PHP/update_order.php', ordersApp.updateOrder)
			.then(function(res){
				ordersApp.GetOrders()
				ordersApp.updateOrder.id = 0
			})
			.catch(function(error){
				ERR(error)
			})
		},

		Main: function(){
			this.GetOrders()
		}
	}
})

ordersApp.Main()
