<?php require 'TEMPLATES/header.php';  ?>

<div id="branchesApp">
	<h1>Филиалы</h1>
	<table class="table">
		<tr>
			<th>Город</th>
			<th>Улица</th>
			<th>Дом</th>
			<th colspan="2">Действие</th>
		</tr>
		<tr v-for="branch in branches" v-if="branch.id_branch !== updateBranch.id">
			
				<td>{{branch.city}}</td>
				<td>{{branch.street}}</td>
				<td>{{branch.home}}</td>
				<td>
					<button v-on:click="GetUpdateBranch(branch)">Изменить</button>
				</td>
				<td>
					<button v-on:click="DeleteBranch(branch.id_branch)">Удалить</button>
				</td>
			
			<tr v-else>
				<td><input type="text" v-model="updateBranch.city"></td>
				<td><input type="text" v-model="updateBranch.street"></td>
				<td><input type="text" v-model="updateBranch.home"></td>
				<td><button v-on:click="UpdateBranch(branch.id_branch)">Обновить</button></td>
				<td><button v-on:click="updateBranch.id = 0">Отмена</button></td>
			</tr>
		</tr>

		<tr>
			<td><input type="text" v-model="newBranch.city"></td>
			<td><input type="text" v-model="newBranch.street"></td>
			<td><input type="text"v-model="newBranch.home"></td>
			<td colspan="2"><button v-on:click="AddBranch">Добавить!</button></td>
		</tr>
	</table>

</div>

<script src="JS/branches.js"></script>

<?php require 'TEMPLATES/footer.php';  ?>