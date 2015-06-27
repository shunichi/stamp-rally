describe User do
  describe '#user_type' do
    it 'ENV["MASTER_NAMES"] に含まれる名前の場合 master になる' do
      # master1, master2, master3 は .env.test の MASTER_NAMES に含まれる
      %w(master1 master2 master3).each do |name|
        expect(create(:user, name: name).user_type).to eq 'master'
      end
    end

    it 'ENV["MASTER_NAMES"] に含まれない名前の場合 trainee になる' do
      expect(create(:user).user_type).to eq 'trainee'
    end
  end
end
