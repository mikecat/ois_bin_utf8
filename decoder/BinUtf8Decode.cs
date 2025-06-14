using System;
using System.Text;

class BinUtf8Decode
{
	public static void Main(string[] args)
	{
		Console.OutputEncoding = Encoding.UTF8;
		bool initialMode = true;
		bool skipFlag = false;
		int bytesLeft = 0;
		int bitsLeft = 8;
		int spBitsLeft = 0;
		int output = 0;
		int input;
		while ((input = Console.Read()) != -1)
		{
			if (input != '0' && input != '1') continue;
			if (initialMode) {
				if (input == '1') {
					bytesLeft++;
				} else {
					if (bytesLeft == 4) {
						spBitsLeft = 11;
						output = 0x1b;
					}
					if (bytesLeft == 0) bytesLeft++;
					initialMode = false;
				}
				bitsLeft--;
			} else {
				if (bitsLeft == 0) {
					bitsLeft = 8;
					skipFlag = true;
				} else {
					if (skipFlag) {
						skipFlag = false;
					} else {
						output = output << 1;
						if (input == '1') output++;
						if (spBitsLeft > 0) {
							spBitsLeft--;
							if (spBitsLeft == 0) {
								output -= 0x40;
								Console.Write((char)output);
								output = 0x37;
							}
						}
					}
				}
				bitsLeft--;
				if (bitsLeft == 0) {
					bytesLeft--;
					if (bytesLeft == 0) {
						Console.Write((char)output);
						output = 0;
						initialMode = true;
						bitsLeft = 8;
					}
				}
			}
		}
	}
}
