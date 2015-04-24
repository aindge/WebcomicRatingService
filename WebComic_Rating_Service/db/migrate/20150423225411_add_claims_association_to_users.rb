class AddClaimsAssociationToUsers < ActiveRecord::Migration
  def self.up
      add_index 'claims', ['user_id'], :name => 'index_user_claim_id' 
  end
end
