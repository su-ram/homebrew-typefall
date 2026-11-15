cask "typefall" do
  version "0.1.0"
  sha256 "da637fb0b8e98ab731a4128ccda44b6f5e19ca7ef11f5ad6ea5bec5d6bce6085"

  url "https://github.com/su-ram/typefall/releases/download/v#{version}/Typefall-#{version}.zip"
  name "Typefall"
  desc "Snow, stardust and Christmas fireworks that fall across your screen as you type"
  homepage "https://github.com/su-ram/typefall"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Typefall.app"

  # 이 앱은 Apple 공증을 받지 않은 ad-hoc 서명 빌드라서, 내려받은 파일의 격리(quarantine) 표시를 제거한다.
  # 소스 전체가 공개돼 있고 직접 빌드할 수도 있다. (공증 빌드가 나오면 이 블록은 삭제 예정)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Typefall.app"],
                   must_succeed: false
  end

  uninstall quit: "dev.typefall.app"

  zap trash: "~/Library/Preferences/dev.typefall.app.plist"

  caveats <<~EOS
    Typefall은 타자 입력을 감지하기 위해 "입력 모니터링" 권한이 필요합니다.
      시스템 설정 → 개인정보 보호 및 보안 → 입력 모니터링 → Typefall 켜기
    키 내용은 저장하거나 전송하지 않으며, 입력 횟수만 계산합니다.
    (선택 기능인 "크리스마스 효과"를 켜면 해당 단어의 키 순서 진행 상태만 이 기기 안에서 확인합니다.)

    앱은 Apple 공증을 받지 않은 빌드입니다. 설치 직후 한 번 실행하세요:
      open -a Typefall
  EOS
end
