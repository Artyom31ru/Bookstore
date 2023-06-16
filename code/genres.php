<?php require 'TEMPLATES/header.php';  ?>

<div id="genresApp">
	<h1>Жанры</h1>
	<table class="table">
		<tr>
			<th>Жанр</th>
			<th colspan="2">Действие</th>
		</tr>
		<tr v-for="genre in genres" v-if="genre.id_genre !== updateGenre.id">
				<td>{{genre.genre}}</td>
				<td>
					<button v-on:click="GetUpdateGenre(genre)">Изменить</button>
				</td>
				<td>
					<button v-on:click="DeleteGenre(genre.id_genre)">Удалить</button>
				</td>
			
			<tr v-else>
				<td><input type="text" v-model="updateGenre.genre"></td>
				<td><button v-on:click="UpdateGenre(genre.id_genre)">Обновить</button></td>
				<td><button v-on:click="updateGenre.id = 0">Отмена</button></td>
			</tr>
		</tr>

		<tr>
			<td><input type="text" v-model="newGenre.genre"></td>
			<td colspan="2"><button v-on:click="AddGenre">Добавить!</button></td>
		</tr>
	</table>

</div>

<script src="JS/genres.js"></script>

<?php require 'TEMPLATES/footer.php';  ?>