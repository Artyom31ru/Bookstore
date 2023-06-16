<?php require 'TEMPLATES/header.php';  ?>

<div id="sellersApp">
	<h1>Продавцы</h1>
	<table>
		<tr>
			<td>Сортировка:</td>
		</tr>
		<tr><form>
			<td>
				<input type="radio" id="dSort" value="order by id_seller" v-model="sort" v-on:change="GetSellers">
				<label for="dSort">Отключить</label>
			</td>
			<td>
				<input type="radio" id="up_down_salary" value="order by salary" v-model="sort" v-on:change="GetSellers">
				<label for="up_down_salary">По возрастанию зарплаты</label>
			</td>
			<td>
				<input type="radio" id="down_up_salary" value="order by salary desc" v-model="sort" v-on:change="GetSellers">
				<label for="down_up_salary">По убыванию зарплаты</label>
			</td>
		</form></tr>
	</table>

	<table class="table">
		<tr>
			<th>Фамилия</th>
			<th>Имя</th>
			<th>Отчество</th>
			<th>Филиал</th>
			<th>Зарплата</th>
			<th colspan="2">Действие</th>
		</tr>
		<tr v-for="seller in sellers" v-if="seller.id_seller !== updateSeller.id">
			
				<td>{{seller.surname}}</td>
				<td>{{seller.firstname}}</td>
				<td>{{seller.patronymic}}</td>
				<td>{{seller.city + ', ' + seller.street + ', ' + seller.home}}</td>
				<td>{{seller.salary}}</td>
				<td>
					<button v-on:click="GetUpdateSeller(seller)">Изменить</button>
				</td>
				<td>
					<button v-on:click="DeleteSeller(seller.id_seller)">Удалить</button>
				</td>
			
			<tr v-else>
				<td><input type="text" v-model="updateSeller.surname"></td>
				<td><input type="text" v-model="updateSeller.firstname"></td>
				<td><input type="text" v-model="updateSeller.patronymic"></td>
				<td>
					<select v-model="updateSeller.branch_id">
						<option v-for="branch in branches" v-bind:value="branch.id_branch">
							{{branch.city + ', ' + branch.street + ', ' + branch.home}}
						</option>
					</select>
				</td>
				<td><input type="number" step="0.01" v-model="updateSeller.salary"></td>
				<td><button v-on:click="UpdateSeller(seller.id_seller)">Обновить</button></td>
				<td><button v-on:click="updateSeller.id = 0">Отмена</button></td>
			</tr>
		</tr>

		<tr>
			<td><input type="text" v-model="newSeller.surname"></td>
			<td><input type="text" v-model="newSeller.firstname"></td>
			<td><input type="text" v-model="newSeller.patronymic"></td>
			<td>
				<select v-model="newSeller.branch_id">
					<option disabled value="0">Выберете филиал:</option>
					<option v-for="branch in branches" v-bind:value="branch.id_branch">
						{{branch.city + ', ' + branch.street + ', ' + branch.home}}
					</option>
				</select>
			</td>
			<td><input type="number" step="0.01" v-model="newSeller.salary"></td>
			<td colspan="2"><button v-on:click="AddSeller">Добавить!</button></td>
		</tr>
	</table>

</div>

<script src="JS/sellers.js"></script>

<?php require 'TEMPLATES/footer.php';  ?>