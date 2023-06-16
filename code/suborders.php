<?php require 'TEMPLATES/header.php'; ?>

<div id="subordersApp">
	<h1>Подзаказы</h1>
	<table>
		<tr>
			<td><b>Покупатель: </b>
			{{orderInfo.b_surname + ' ' + orderInfo.b_firstname}}</td>
		</tr>
		<tr>
			<td><b>Продавец: </b>
			{{orderInfo.s_surname + ' ' + orderInfo.s_firstname}}</td>
		</tr>
		<tr>
			<td><b>Филиал: </b>
			{{orderInfo.city + ', ' + orderInfo.street + ', ' + orderInfo.home}}</td>			
		</tr>
	</table>
	<table class="table">
		<tr>
			<th>Название</th>
			<th>Автор</th>
			<th>Жанр</th>
			<th>Количество</th>
			<th colspan="2">Действие</th>
		</tr>
		<tr v-for="suborder in suborders" v-if="suborder.id_suborder !== updateSuborder.id">
			
				<td>{{suborder.title}}</td>
				<td>{{suborder.author}}</td>
				<td>{{suborder.genre}}</td>
				<td>{{suborder.quantity}}</td>
				<td>
					<button v-on:click="GetUpdateSuborder(suborder)">Изменить</button>
				</td>
				<td>
					<button v-on:click="DeleteSuborder(suborder.id_suborder)">Удалить</button>
				</td>
		</tr>
		<tr v-else>
			<td>{{suborder.title}}</td>
			<td>{{suborder.author}}</td>
			<td>{{suborder.genre}}</td>
			<td><input type="number" v-model="updateSuborder.quantity"></td>
			<td><button v-on:click="UpdateSuborder(suborder.id_suborder)">Обновить</button></td>
			<td><button v-on:click="updateSuborder.id = 0">Отмена</button></td>
		</tr>
		
		<tr v-if="books.length">
			<td colspan="3">
				<select v-model="newSuborder.book_id">
					<option disabled value="0">Выберете книгу:</option>
					<option v-for="book in books" v-bind:value="book.id_book">
						{{book.title + ', ' + book.author + ' - ' + book.total}}
					</option>
				</select>
			</td>
			<td><input type="number" v-model="newSuborder.quantity"></td>
			<td colspan="2"><button v-on:click="AddSuborder">Добавить!</button></td>
		</tr>
	</table>
</div>

<script src="JS/suborders.js"></script>

<?php require 'TEMPLATES/footer.php';  ?>