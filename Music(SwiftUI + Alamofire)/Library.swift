//
//  Library.swift
//  Music(SwiftUI + Alamofire)
//
//  Created by Mikhail on 05.04.2021.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    //MARK: - Screen setting
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    GeometryReader { geometry in
                        HStack(spacing: 20) {
                            Button(action: {
                                self.track = self.tracks[0]
                                self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                            }, label: {
                                Image(systemName: "play.fill")
                                    .frame(width: abs(geometry.size.width / 2 - 10), height: 50)
                                    .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                    .background(Color.init(#colorLiteral(red: 0.8910667896, green: 0.8859985471, blue: 0.8947127461, alpha: 1)))
                                    .cornerRadius(10)
                            })
                            Button(action: {self.tracks = UserDefaults.standard.savedTracks()}, label: {
                                Image(systemName: "arrow.2.circlepath")
                                    .frame(width: abs(geometry.size.width / 2 - 10), height: 50)
                                    .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                    .background(Color.init(#colorLiteral(red: 0.8910667896, green: 0.8859985471, blue: 0.8947127461, alpha: 1)))
                                    .cornerRadius(10)
                            })
                        }
                    }.padding().frame(height:50)
                    Divider().padding(.leading)
                        .padding(.trailing)
                        .padding(.top)
                    Spacer()
                }
                .navigationBarTitle("Library")
            }
            .frame(height: 175.0)
            
            List{
                ForEach(tracks) { track in
                    LibraryCell(cell: track).gesture(TapGesture().onEnded({ _ in
                        let keyWindow  = UIApplication.shared.connectedScenes
                            .filter({ $0.activationState == .foregroundActive})
                            .map ({ $0 as? UIWindowScene})
                            .compactMap({$0})
                            .first?.windows
                            .filter({$0.isKeyWindow}).first
                        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                        tabBarVC?.trackDetailView.delegate = self
                        
                        self.track = track
                        self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                    }))
                }.onDelete(perform: delete)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}
//MARK: - Сell setting
struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(url: URL(string: cell.iconUrlString ?? "")!, content: { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60).cornerRadius(5)
            })
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
// MARK: - TrackMovingDelegate
extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex - 1 == tracks.count {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
}

