class Song
  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @name = name
    @album = album
    @id = id
  end

  def self.create_table
    DB[:conn].execute(<<-SQL)
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
    SQL
  end

  def self.create(name:, album:)
    song = new(name: name, album: album)
    song.save
  end

  def save
    DB[:conn].execute("INSERT INTO songs (name, album) VALUES (?, ?)", [name, album])
    self.id = DB[:conn].last_insert_row_id
    self
  end
end
