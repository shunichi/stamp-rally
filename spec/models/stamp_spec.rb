describe Stamp do
  describe 'validation' do
    set_envs_around(MASTER_NAMES: 'master1,master2,master3')

    let(:master1) { create(:master, name: 'master1') }
    let(:master2) { create(:master, name: 'master2') }
    let(:trainee1) { create(:user) }
    let(:trainee2) { create(:user) }

    it 'master は trainee にスタンプを押せる' do
      stamp = master1.sent_stamps.create(trainee: trainee1)
      expect(stamp).to be_valid
    end

    it 'trainee はスタンプを押せない' do
      stamp = trainee1.sent_stamps.create(trainee: trainee2)
      expect(stamp).not_to be_valid
    end

    it 'master はスタンプをもらえない' do
      stamp = master1.sent_stamps.create(trainee: master2)
      expect(stamp).not_to be_valid
    end
  end
end