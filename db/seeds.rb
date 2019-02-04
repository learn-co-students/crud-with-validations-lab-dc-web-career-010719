Song.destroy_all
Song.create!(title: "Song1", released: true, release_year: 1990, artist_name: "Artist1", genre: "Genre1")
Song.create!(title: "Song2", released: false, artist_name: "Artist2", genre: "Genre2")