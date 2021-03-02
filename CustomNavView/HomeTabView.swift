//
//  HomeTabView.swift
//  CustomNavView
//
//  Created by 王小劣 on 2021/2/28.
//

import SwiftUI

// bottom only rounded corners
struct RoundedShape: Shape {
    // for reusable
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 45, height: 45))

        return Path(path.cgPath)
    }
}

struct HomeTabView: View {
    // let maxHeight = UIScreen.main.bounds.height / 2.3
    @State var y:CGFloat = 0
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.opacity(0.1)
            VStack(spacing: 1) {
                CustomNavView()
                    .padding(.bottom, 10)

                ScrollView {
                    VStack(spacing: 1) {
                        ADimgView()
                            .frame(height: 150)

                        ScrollView() {
                            MenuView()
                        }
                        .background(Color.white)
                        //.clipShape(RoundedShape(corners: .al))
                        .cornerRadius(20)
                        .padding()

                        GeometryReader { reader -> AnyView in
                            y = reader.frame(in: .global).minY
                            return AnyView(
                                SubTitle()
                                    .frame(height: 50)
                                    .opacity(y > 120 ? 1 : 0)
                            )
                        }
                        .frame(height: 50)

                        ForEach(1 ..< 20) {_ in
                            GoodsInfoView()
                                .background(Color.white)
                                .cornerRadius(20)
                        }
                        .padding([.horizontal, .top, .bottom])

                        BottomView()
                    }
                }
            }
            SubTitle()
                .background(Color.white)
                .opacity(y > 120 ? 0 : 1)
                .offset(y: 80)
                .frame(height: 50)

        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
}


//struct ADimgView: View {
//    @State var currentIndex: Int = 0
//    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
//    var body: some View {
//        TabView(selection: $currentIndex){
//            ForEach(1 ..< 5) {index in
//                CardView(imgindex: index)
//                    .tag(index)
//            }
//        }
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//        .cornerRadius(10)
//        .padding()
//        .onReceive(timer) { _ in
//            withAnimation {
//                self.currentIndex = (self.currentIndex + 1) % 4
//            }
//        }
//    }
//}



struct GoodsInfoView: View {
    var body: some View {
            HStack {
                Color.blue
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text("天龙八部")
                        .font(.title2)
                        .lineLimit(1)

                    Text("《天龙八部》是中国现代作家金庸创作的长篇武侠小说。")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .padding(.bottom)

                    HStack {
                        Text("$99.00")
                            .font(.title)
                            .foregroundColor(.red)
                            .lineLimit(1)

                        Text("$99.00")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .strikethrough()
                            .lineLimit(1)
                    }

                }
                .padding([.leading, .bottom, .top])
            }
            .padding()

    }
}



struct CardView: View {
    let imgindex: Int
    var body: some View {
        Image("img\(imgindex)")
            .resizable()
            .frame(height: 150)
    }
}

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {

        ZStack(alignment: .topLeading) {
            Color.white
            Button(action: {
               self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward").padding()
            }

        }
        .navigationBarBackButtonHidden(true)

        //.navigationBarHidden(true)

    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}


struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}

struct MenuView: View {
    let items = 1...8
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                     spacing: 30),count: 5)) {

            VStack {
                NavigationLink(
                    destination: DetailView(),
                    label: {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 60, height: 60)
                    })

                Text("礼品")
                    .font(.caption)
            }
            VStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 60, height: 60)
                Text("充值卡")
                    .font(.caption)
            }
            ForEach(items, id: \.self) { item in
                VStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 60, height: 60)
                    Text("xxxx")
                        .font(.caption)
                }

            }

        }
        .padding()
    }
}

struct SubTitle: View {
    var body: some View {
        HStack {
            VStack {
                Text("推荐商品")
                    .font(.headline)

                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding()

            VStack {
                Text("全部商品")
                    .font(.headline)

                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 40, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding()

            Spacer()
        }

    }
}

struct CustomNavView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("首页")
                .font(.headline)
                .offset(y: 15.0)
            Spacer()
        }
        .frame(height: 88)
        .background(Color.white)
    }
}

struct BottomView: View {
    var body: some View {
        Text("--- 到底了 别滑了 ---")
            .padding()
    }
}
