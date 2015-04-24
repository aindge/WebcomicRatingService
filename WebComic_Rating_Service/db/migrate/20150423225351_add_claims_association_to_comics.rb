class AddClaimsAssociationToComics < ActiveRecord::Migration
  def self.up
      add_index 'claims', ['comic_id'], :name => 'index_comic_claim_id' 
  end
end
