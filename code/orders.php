<?php require 'TEMPLATES/header.php';  ?>

<div id="ordersApp">
	<h1>Заказы</h1>
	<table class="table">
		<tr>
			<th>Покупатель</th>
			<th>Продавец</th>
			<th>Филиал</th>
			<th>Сумма заказа</th>
			<th>Дата заказа</th>
			<th colspan="3">Действие</th>
		</tr>
		<tr v-for="order in orders" v-if="order.id_order !== updateOrder.id">
			<td>{{order.b_surname + ' ' + order.b_firstname}}</td>
			<td>{{order.s_surname + ' ' + order.s_firstname}}</td>
			<td>{{order.city + ', ' + order.street + ', ' + order.home}}</td>
			<td>{{order.sum_order}}</td>
			<td>{{order.date_order}}</td>
			<td>
				<button v-on:click="GetUpdateOrder(order)">
					Изменить
				</button>
			</td>
			<td>
				<button v-on:click="DeleteOrder(order.id_order)">
					Удалить
				</button>
			</td>
			<td>
				<button v-on:click="GoToSuborders(order.id_order)">Подзаказы</button>
			</td>
		</tr>
		<tr v-else>
			<td>
				<select v-model="updateOrder.buyer_id">
					<option v-for="buyer in buyers" v-bind:value="buyer.id_buyer">
						{{buyer.surname + ' ' + buyer.firstname}}
					</option>
				</select>
			</td>
			<td>
				<select v-model="updateOrder.seller_id">
					<option v-for="seller in sellers" v-bind:value="seller.id_seller">
						{{seller.surname + ' ' + seller.firstname}}
					</option>
				</select>
			</td>
			<td>{{order.city + ', ' + order.street + ', ' + order.home}}</td>
			<td>{{order.sum_order}}</td>
			<td>{{order.date_order}}</td>
			<td>
				<button v-on:click="UpdateOrder(order.id_order)">
					Обновить
				</button>
			</td>
			<td>
				<button v-on:click="updateOrder.id = 0">
					Отмена
				</button>
			</td>
		</tr>
		<tr>
			<td>
				<select v-model="newOrder.buyer_id">
					<option disabled value="0">Выберете покупателя:</option>
					<option v-for="buyer in buyers" v-bind:value="buyer.id_buyer">
						{{buyer.surname + ' ' + buyer.firstname}}
					</option>
				</select>
			</td>
			<td>
				<select v-model="newOrder.seller_id">
					<option disabled value="0">Выберете продавца:</option>
					<option v-for="seller in sellers" v-bind:value="seller.id_seller">
						{{seller.surname + ' ' + seller.firstname + ', ' + seller.city}}
					</option>
				</select>
			</td>
			<td></td>
			<td></td>
			<td>{{date}}</td>
			<td colspan="3"><button v-on:click="AddOrder">Добавить!</button></td>
		</tr>
	</table>
</div>

<script src="JS/orders.js"></script>

<?php require 'TEMPLATES/footer.php';  ?>