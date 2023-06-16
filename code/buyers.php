<?php require 'TEMPLATES/header.php';  ?>

<div id="buyersApp">
	<h1>Покупатели</h1>
	<table class="table">
		<tr>
			<th>Фамилия</th>
			<th>Имя</th>
			<th>Телефон</th>
			<th colspan="2">Действие</th>
		</tr>
		<tr v-for="buyer in buyers" v-if="buyer.id_buyer !== updateBuyer.id">
			
				<td>{{buyer.surname}}</td>
				<td>{{buyer.firstname}}</td>
				<td>{{buyer.phone}}</td>
				<td>
					<button v-on:click="GetUpdateBuyer(buyer)">Изменить</button>
				</td>
				<td>
					<button v-on:click="DeleteBuyer(buyer.id_buyer)">Удалить</button>
				</td>
			
			<tr v-else>
				<td><input type="text" v-model="updateBuyer.surname"></td>
				<td><input type="text" v-model="updateBuyer.firstname"></td>
				<td><input type="text" v-model="updateBuyer.phone"></td>
				<td><button v-on:click="UpdateBuyer(buyer.id_buyer)">Обновить</button></td>
				<td><button v-on:click="updateBuyer.id = 0">Отмена</button></td>
			</tr>
		</tr>

		<tr>
			<td><input type="text" v-model="newBuyer.surname"></td>
			<td><input type="text" v-model="newBuyer.firstname"></td>
			<td><input type="text"v-model="newBuyer.phone"></td>
			<td colspan="2"><button v-on:click="AddBuyer">Добавить!</button></td>
		</tr>
	</table>

</div>

<script src="JS/buyers.js"></script>

<?php require 'TEMPLATES/footer.php';  ?>