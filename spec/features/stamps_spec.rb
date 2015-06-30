feature 'Stamps page' do
  context 'masterとしてログイン' do
    scenario 'traineeのスタンプが押せる'
    scenario 'traineeのスタンプが削除できる'
  end

  context 'trainee としてログイン' do
    scenario 'スタンプは押せない'
  end
end