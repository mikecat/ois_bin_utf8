initialMode
skipFlag
spBitsLeft
bitsLeft
sync_0_a
sync_1_a
sync_1_b
sync_1_c
sync_1_d
sync_0_b
bytesLeft
output
input
input_cmp_work1 / output_work1
input_cmp_work2 / input_valid_flag / output_work2

// 初期値を設定する (initialMode = 1; bitsLeft = 8; sync_1_* = 1)
// ポインタを input に置く
+>>>++++++++>>+>+>+>+>>>>
// 入力を読み取る
,+
[
  // 入力に1足した値がinputに入っている
  // 入力がマイナス1(EOF)の場合は0になって終了
  // input_cmp_work1 = 49; input_valid_flag = 2; ポインタ → input_cmp_work1
  // input_cmp_work2 を使用し、6*8に1を足して49を作る
  >>++++++++[<++++++>-]<+>++<
  // input から input_cmp_work1 を引く
  [<->-]
  // input が 0 でなければ、input_valid_flag から 1 を引く
  <[>>-<<<<<]
  // ポインタが input または sync_0_b にあるので、sync_0_b に統一する
  <<<[>]
  // input から 1 を引き、0 でなければ、input_valid_flag から 1 を引く
  >>>-[>>-<<<<<]
  // ポインタが input または sync_0_b にあるので、sync_0_b に統一する
  <<<[>]
  // input に 1 を足す (入力が 0 なら 0、1 なら 1 にする)
  >>>+
  // input_valid_flag をチェックし、0 でなければ文字の処理を行う
  >>[
    // input_valid_flag を 0 にする
    -
    // initialMode で分岐する
    <<<<<<<<<<<<<<[
      // initialMode が 1 のとき
      // bitsLeft から 1 を引く
      >>>-
      // input で分岐する
      >>>>>>>>>[
        // input が 1 のとき
        // bytesLeft に 1 を足す
        <<+
        // ポインタを sync_0_b に移す → 次の移動で sync_0_a に移る
        <
      ]<<<<<[
        // input が 0 のとき (ポインタは sync_1_c にある)
        // bytesLeft が 4 かを判定する
        // 4 であればポインタは sync_1_a に、4 でなければポインタは sync_0_a に移る
        >>>----[<]<<<<<
        // bytesLeft が 4であれば、以下の処理を行う
        [
          // output_work1 を用いて、output を 0x1b にする
          >>>>>>>>+++++[<<+++++>>-]<<++
          // spBitsLeft を 11 にする
          <<<<<<<<<+++++++++++
          // ポインタを sync_0_a に移す
          >>
        ]
        // ポインタを bytesLeft に移し、値を復元する
        >>>>>>++++
        // ポインタを bytesLeft が 0 であれば sync_0_b に、0 でなければ sync_1_d に移す
        [<]<
        // bytesLeft が 0 でなければ、bytesLeft から 1 を引き、ポインタを sync_0_b に移す
        [>>-<]
        // bytesLeft に 1 を足す
        // これにより、bytesLeft が 0 だったら 1 を足し、0 でなかったらそのまま、となる
        >+
        // initialMode を 0 にする
        <<<<<<<<<<-
        // ポインタを sync_0_a に移す
        >>>>
      ]
      // ポインタは sync_0_a にある → 次の移動で sync_0_b に移る
    ]>>>>>[
      // initialMode が 0 のとき (ポインタは sync_1_a にある)
      // bitsLeft で分岐する
      <<[
        // bitsLeft が 0 でないとき
        // skipFlag で分岐する
        <<[
          // skipFlag が 1 のとき
          // skipFlag を 0 にする
          -
          // ポインタを sync_0_a に移す → 次の移動で sync_0_b に移る
          >>>
        ]>>>>>[
          // skipFlag が 0 のとき (ポインタは sync_1_b にある)
          // output_work1 を用いて output を 2 倍にする
          // カーソルは output_work1 に移る
          >>>>>[>>++<<-]>>[<<+>>-]
          // input が 1 なら、output に 1 を足す (input は 0 になる)
          <[<+>-]
          // ポインタを sbBitsLeft が 0 ならsync_0_a に、0 でなければ sync_1_b に移す
          <<<<<<<<<<[>>]>>
          // sbBitsLeft が 0 でなければ、以下を行う
          [
            // sbBitsLeft から 1 を引く
            <<<<-
            // ポインタを sbBitsLeft が 0 なら sync_1_c に、0 でなければ sync_0_b に移す
            [>>]>>>>>
            // sbBitsLeft が 0 であれば、以下を行う
            [
              // output_work1 を用いて、output から 0x40 を引く
              >>>>>>++++++++[<<-------->>-]
              // output を出力し、0 にする
              <<.[-]
              // output_work1 を用いて、output を 0x37 にする
              >>+++++[<<+++++++++++>>-]
              // ポインタを sync_0_b に移す
              <<<<
            ]
            // ポインタを sync_0_b から sync_0_a に移す
            <<<<<
          ]
          // ポインタを sync_0_a から sync_0_b に移す
          >>>>>
        ]
        // ポインタを sync_0_b から sync_0_a に移す → 次の移動で sync_0_b に移る
        <<<<<
      ]>>>>>[
        // bitsLeft が 0 のとき (ポインタは sync_1_d にある)
        // bitsLeft を 8 にする
        <<<<<++++++++
        // skipFlag を 1 にする
        <<+
        // ポインタを sync_0_b に移す
        >>>>>>>>
      ]
      // ポインタを sync_0_b から移し、bitsLeft から 1 を引く
      <<<<<<-
      // ポインタを bitsLeft が 0 なら sync_1_d に、0 でないなら sync_0_b に移す
      [>]>>>>>
      // bitsLeft が 0 なら、以下を実行する
      [
        // bytesLeft から 1 を引く
        >>-
        // ポインタを bytesLeft が 0 なら sync_1_a に、0 でないなら sync_0_a に移す
        [<]<<<<<
        // bytesLeft が 0 なら、以下を実行する
        [
          // output を出力し、0 にする
          >>>>>>.[-]
          // initialMode を 1 にする
          <<<<<<<<<<<+
          // bitsLeft を 8 にする
          >>>++++++++
          // ポインタを sync_0_a に移す
          >
        ]
        // ポインタを sync_0_b に移す
        >>>>>
      ]
      // ポインタは sync_0_b にある
    ]
    // ポインタを sync_0_b から input_valid_flag に移す
    >>>>>
  ]
  // ポインタを input_valid_flag から input に移し、次の入力を読み取る
  <<,+
]
