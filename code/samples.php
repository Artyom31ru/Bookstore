<?php require 'TEMPLATES/header.php';  ?>

<div id="samplesApp">
	<h1>Экземпляры</h1>
	<select v-model="branchID" v-on:change="GetSamples">
		<option disabled value="">Выберете филиал:</option>
		<option v-for="branch in branches" v-bind:value="branch.id_branch">
			{{branch.city}}
		</option>
	</select>

	<table v-if="branchID > 0"  class="table">
		<tr>
			<th>Название</th>
			<th>Автор</th>
			<th>Жанр</th>
			<th>Количество</th>
			<th colspan="2">Действие</th>
		</tr>
		<tr v-for="sample in samples" v-if="sample.id_sample !== updateSample.id">
			
				<td>{{sample.title}}</td>
				<td>{{sample.author}}</td>
				<td>{{sample.genre}}</td>
				<td>{{sample.total}}</td>
				<td>
					<button v-on:click="GetUpdateSample(sample)">Изменить</button>
				</td>
				<td>
					<button v-on:click="DeleteSample(sample.id_sample)">Удалить</button>
				</td>
		</tr>
		<tr v-else>
			<td>{{sample.title}}</td>
			<td>{{sample.author}}</td>
			<td>{{sample.genre}}</td>
			<td><input type="number" v-model="updateSample.total"></td>
			<td><button v-on:click="UpdateSample(sample.id_sample)">Обновить</button></td>
			<td><button v-on:click="updateSample.id = 0">Отмена</button></td>
		</tr>
		
		<tr v-if="nullBooks.length">
			<td colspan="3">
				<select v-model="newSample.book_id">
					<option disabled value="0">Выберете книгу:</option>
					<option v-for="book in nullBooks" v-bind:value="book.id_book">
						{{book.title + ' - ' + book.author + ' - ' + book.genre}}
					</option>
				</select>
			</td>
			<td><input type="number" v-model="newSample.total"></td>
			<td colspan="2"><button v-on:click="AddSample">Добавить!</button></td>
		</tr>
	</table>
</div>

<script src="JS/samples.js"></script>

<?php require 'TEMPLATES/footer.php';  ?>