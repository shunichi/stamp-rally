describe User do
  describe '#user_type' do
    set_envs_around(MASTER_NAMES: 'master1,master2,master3')

    it 'ENV["MASTER_NAMES"] に含まれる名前の場合 master になる' do
      %w(master1 master2 master3).each do |name|
        expect(create(:user, name: name).user_type).to eq 'master'
      end
    end

    it 'ENV["MASTER_NAMES"] に含まれない名前の場合 trainee になる' do
      expect(create(:user).user_type).to eq 'trainee'
    end
  end
end
