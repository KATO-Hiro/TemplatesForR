# TemplatesForR

R����Ōv�Z�E�`�悷�邽�߂̃e���v���[�g

## �X�N���v�g�����s���邱�Ƃœ�����A�E�g�v�b�g

Note: �}�̒ǉ��E�폜�ɉ����čX�V���Ă��������D

- �}: TODO: Write here!
  TODO: Write here! (src\output\hoge)

## �t�@�C���E�f�B���N�g���\��

```terminal
src
  main.r: ��v�Ȍv�Z���}���s���X�N���v�g�ł��D

  - docs: ���f�[�^�Ɋւ�������⒍�ӎ����Ȃǂ��܂Ƃ߂��t�H���_�ł��D

  - input: ���̓f�[�^�Ɋւ���t�@�C�����܂Ƃ߂��t�H���_�ł��D

  - output: �v�Z���ʂ�}���܂Ƃ߂��t�H���_�ł��D

  - preparation: �O�������s�����߂̃X�N���v�g�ł��D

  - pilot_study: �\���������s�����߂̃X�N���v�g�ł��D

  - lib: �ėp�I�ȏ������܂Ƃ߂��X�N���v�g�ł��D

  - common: �{�v���W�F�N�g�ŗL�̋��ʏ������܂Ƃ߂��X�N���v�g�ł��D

  - scripts: �R�}���h�̏��������s���邽�߂̃X�N���v�g�ł��D
    - pull.cmd: Git�����Git Hub�Ń\�[�X�R�[�h���Ǘ����Ă���C�Y������\�t�g�E�F�A�𗘗p����ۂɃ^�C�v�ʂ����炷���Ƃ��ł��܂��D

  - log: �v�Z�̓r���o�߂��o�͂����t�@�C��������t�H���_�ł��D�v���O�����̕s��̓���ɖ𗧂��܂��D

  - backup: �o�b�N�A�b�v����邽�߂̃t�H���_�ł��D

  - tmp: �t�@�C����t�H���_���ꎞ�I�ɑޔ������邽�߂̃t�H���_�ł��D

  - trashbox: �g��Ȃ��\�����������̂́C�폜���邩�ǂ��������Ă���t�@�C���E�t�H���_��u���܂��D
```

## �g����

1. ��ƃf�B���N�g���Ɉړ����܂��D

��: �f�B���N�g���̃p�X���G�N�X�v���[���[����R�s�[�����ꍇ�́C�u\�v���u\\�v�ɕύX���Ă��������D

```terminal
setwd("C:\\Users\\yourname\\(your PATH)\\")

ex:
setwd("C:\\Users\\KATO-Hiro\\Documents\\work\\")
```

2. (����̂�)R�Ŏg�p����p�b�P�[�W���C���X�g�[�����܂��D

```terminal
source("installer.r")
```

3. �ȉ��̃R�}���h�����s���āC�v�Z��}�̕`����s���܂��D

- RStudio�Ŏ��s����R�}���h

```terminal
# �\������(���Ȃ��f�[�^�Ŏ��s���낷�邽�߂̃X�N���v�g)���s���܂��D
source("src\\pilot_study\\main.r")

# �v�Z�E�}�̕`����s���܂��D
source("src\\main.r")
```

## �X�N���v�g�̉��ς���ъg���������Ɍ��������

�I�v�V�����ō��ڂ�؂�ւ�����C�p�^�[���𑝂₵���肷�邱�Ƃ��ł��܂��D

### �O����

��: ���͂̑O�������啝�Ɍ��������ꍇ��f�[�^�����������ꍇ�Ȃǂ������āC�ȉ��̃X�N���v�g�����s���邱�Ƃ͂قڂȂ��Ǝv���܂��D

#### TODO: Write here!

- TODO: Write here!(src\preparation\foo.r)
  - ���̓t�@�C��:
    - TODO: Write here!: src\input\hoge.csv
  - �o�͐�: src\output\fuga.csv

  ```md
  fuga.csv

  TODO: Write here!
  ```

### ���̓t�@�C���̃t�H�[�}�b�g

- TODO: write here!
  - src/input/hoge.csv

```md
TODO: write here!
```

- TODO: write here!
  - src/input/hoge.csv

```md
TODO: write here!
```

### �o�̓t�@�C���̃t�H�[�}�b�g

- TODO: write here!
  - src/output/foo.csv

```md
```

- TODO: write here!
  - src/output/foo.csv

```md
```
